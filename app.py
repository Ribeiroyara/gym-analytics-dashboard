import os
import pandas as pd
import streamlit as st
import pymysql
from dotenv import load_dotenv

load_dotenv()

st.set_page_config(
    page_title="Gym Analytics Dashboard",
    page_icon="🏋️",
    layout="wide"
)

st.title("🏋️ Gym Analytics Dashboard")
st.write("Business analytics dashboard connected to MySQL database.")

def get_connection():
    return pymysql.connect(
        host=os.getenv("DB_HOST"),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PASSWORD"),
        database=os.getenv("DB_NAME"),
        port=3306
    )

def load_table(table_name):
    conn = get_connection()
    df = pd.read_sql(f"SELECT * FROM {table_name}", conn)
    conn.close()
    return df

try:
    users = load_table("users")
    members = load_table("members")
    trainers = load_table("trainers")
    workouts = load_table("workouts")
    classes = load_table("classes")
    bookings = load_table("class_booking")
    payments = load_table("payments")
    members_workouts = load_table("members_workouts")

    active_members = len(members[members["status"] == "active"])

    paid_revenue = payments[payments["status"] == "paid"]["amount"].sum()
    pending_revenue = payments[payments["status"] == "pending"]["amount"].sum()
    overdue_revenue = payments[payments["status"] == "overdue"]["amount"].sum()
    total_revenue = payments["amount"].sum()

    st.sidebar.header("Filters")

    selected_member_status = st.sidebar.selectbox(
        "Member Status",
        ["All"] + list(members["status"].unique())
    )

    if selected_member_status != "All":
        filtered_members = members[members["status"] == selected_member_status]
    else:
        filtered_members = members

    st.subheader("📌 Key Metrics")

    col1, col2, col3, col4 = st.columns(4)

    col1.metric("Total Members", len(members))
    col2.metric("Active Members", active_members)
    col3.metric("Trainers", len(trainers))
    col4.metric("Classes", len(classes))

    col5, col6, col7, col8 = st.columns(4)

    col5.metric("Total Revenue", f"${total_revenue:,.2f}")
    col6.metric("Revenue Paid", f"${paid_revenue:,.2f}")
    col7.metric("Pending Revenue", f"${pending_revenue:,.2f}")
    col8.metric("Overdue Revenue", f"${overdue_revenue:,.2f}")

    st.divider()

    left_col, right_col = st.columns(2)

    with left_col:
        st.subheader("👥 Members by Status")
        status_count = members["status"].value_counts()
        st.bar_chart(status_count)

    with right_col:
        st.subheader("💳 Payment Status")
        payment_status = payments["status"].value_counts()
        st.bar_chart(payment_status)

    st.divider()

    left_col, right_col = st.columns(2)

    with left_col:
        st.subheader("🏋️ Most Popular Workouts")

        workout_popularity = members_workouts.merge(
            workouts,
            left_on="workout_id",
            right_on="id"
        )

        workout_count = workout_popularity["title"].value_counts()

        st.bar_chart(workout_count)

    with right_col:
        st.subheader("📚 Most Popular Classes")

        class_popularity = bookings.merge(
            classes,
            left_on="classes_id",
            right_on="id"
        )

        class_count = class_popularity["name"].value_counts()

        st.bar_chart(class_count)

    st.divider()

    st.subheader("👤 Members Data")
    st.dataframe(filtered_members, use_container_width=True)

    st.subheader("💰 Payments Data")
    st.dataframe(payments, use_container_width=True)

    st.subheader("🏋️ Members Workouts Data")
    st.dataframe(members_workouts, use_container_width=True)

except Exception as e:
    st.error("Database connection error")
    st.write(e)