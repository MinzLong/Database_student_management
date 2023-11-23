from flask import Flask, render_template, request, redirect
import mysql.connector

app = Flask(__name__)

# Database Connection
db = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="Minhlong15102004",
    database="student_management"
)

cursor = db.cursor(dictionary=True)


@app.route('/students', methods=['GET'])
def index():
    # Fetch data from the database
    cursor.execute("SELECT * FROM Students;")
    students = cursor.fetchall()

    cursor.execute("SELECT * FROM Classes;")
    classes = cursor.fetchall()

    # Render the HTML template with the fetched data
    return render_template('StudentManage.html', students=students, classes=classes)



def insert_student(student_id,name, email, phone, gender, dob, address, class_id):
    try:
        sql = "INSERT INTO Students (StudentID,Name, Email, Phone_Number, Gender, Date_of_Birth, Address, MajorID) VALUES (%s,%s, %s, %s, %s, %s, %s, %s)"
        values = (student_id,name, email, phone, gender, dob, address, class_id)
        cursor.execute(sql, values)
        db.commit()
        return True
    except Exception as e:
        print(f"Error: {e}")
        db.rollback()
        return False


@app.route('/add_student', methods=['POST', 'GET'])
def add_student_route():
    if request.method == 'POST':
        student_id = request.form['student_id']
        name = request.form['name']
        email = request.form['email']
        phone = request.form['phone']
        gender = request.form['gender']
        dob = request.form['dob']
        address = request.form['address']
        MajorID = request.form['MajorID']

        # Call the insert_student function to insert data into the database
        if insert_student(student_id,name, email, phone, gender, dob, address, MajorID):
            return render_template('AddStudent.html', message='Student added successfully!')
        else:
            return render_template('AddStudent.html', message='Failed to add student. Please try again.')
    
    # For GET requests, return an empty response or render the form
    return render_template('AddStudent.html', message=None)




if __name__ == '__main__':
    app.run(debug=True)
