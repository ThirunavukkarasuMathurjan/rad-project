<%@page import="java.util.List"%>
<%@page import="com.example.myapp.DBConnector"%>
<%@page import="com.example.myapp.Subject"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quiz System</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    </head>

    <body>
        <!--Nav bar-->
        <nav class="navbar navbar-expand-lg navbar-light bg-light justify-content-between">
            <a class="navbar-brand" href="#">
                <img src="ImagesFolder/logoo2.png" height="30" class="d-inline-block align-top" alt="">
                Scholar's Hub
            </a>

            <div class="navbar-nav ml-auto">
                <a class="nav-link" href="signin.jsp">Sign Out</a>
            </div>
        </nav>

        <!--Body-->
        <div class="container mt-5">
            <form id="quizForm" action="addquiz" method="post">
                <!--Title-->
                <div class="row justify-content-between align-items-center">
                    <div class="col-6">
                        <h1>Add New Quiz</h1>
                    </div>

                    <div class="col-6 text-end">
                        <button type="submit" class="btn btn-primary">Create Quiz</button>
                    </div>
                </div>

                <!--Quiz Details-->
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="subject" class="form-label">Subject:</label>
                        <select id="subject" name="subject" class="form-select" required>
                            <%
                            int teacher_id = Integer.parseInt(session.getAttribute("id").toString());

                            DBConnector dBConnection = new DBConnector();
                            List<Subject> subjects = dBConnection.getSubjectsByTeacherId(teacher_id);

                            for (Subject subject : subjects) {
                            %>
                            <option value="<%= subject.getId()%>"><%= subject.getName()%></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label for="quizName" class="form-label">Quiz Name:</label>
                        <input type="text" id="quizName" name="quizName" class="form-control" required>
                    </div>
                </div>
                <div class="row mb-3">
                    <div class="col-md-6">
                        <label for="deadline" class="form-label">Deadline:</label>
                        <input type="date" id="deadline" name="deadline" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label for="duration" class="form-label">Duration (minutes):</label>
                        <input type="number" id="duration" name="duration" class="form-control" required>
                    </div>
                </div>
                <div class="mb-3">
                    <label for="description" class="form-label">Description:</label>
                    <textarea id="description" name="description" class="form-control" rows="4" required></textarea>
                </div>

                <!--Questions-->
                <div id="questionsContainer">
                    <!--Questions will be added by JS--> 
                </div>

                <button type="button" class="btn btn-info mb-3" id="addQuestionBtn">Add Another Question</button>
                <button type="button" class="btn btn-danger mb-3" id="deleteLastQuestionBtn">Delete Last Question</button>
            </form>
        </div>

        <script>
            const questionsContainer = document.getElementById('questionsContainer');

            // Add new Question
            const addQuestionBtn = document.getElementById('addQuestionBtn');
            addQuestionBtn.addEventListener('click', () => {
                let questionCounter = questionsContainer.querySelectorAll(".question").length + 1;
                console.log(questionCounter);
                const newQuestion = document.createElement('div');
                newQuestion.id = "question" + questionCounter;
                newQuestion.classList.add("question");
                newQuestion.innerHTML = `
                        <hr>
                        <h4>Questions ` + questionCounter + `</h4>
                        <div class="mb-3">
                            <label for="question" class="form-label">Question:</label>
                            <input type="text" id="question" name="question` + questionCounter + `" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="answers" class="form-label">Answers (4 comma seperated asnwer):</label>
                            <input type="text" id="answers" name="answers` + questionCounter + `" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label for="correctAnswer" class="form-label">Correct Answer:</label>
                            <select id="correctAnswer" name="correctAnswer` + questionCounter + `" class="form-select" required>
                                <option value="1" selected>1</option>
                                <option value="2">2</option>
                                <option value="3">3</option>
                                <option value="4">4</option>
                            </select>
                        </div>
                        
                `;
                questionsContainer.appendChild(newQuestion);
            });
            
            // Delete last Question
            const deleteLastQuestionBtn = document.getElementById('deleteLastQuestionBtn');
            deleteLastQuestionBtn.addEventListener('click', () => {
                let questions = questionsContainer.querySelectorAll(".question");

                if (questions.length > 0) {
                    const lastQsuestion = questions[questions.length - 1];
                    questionsContainer.removeChild(lastQsuestion);
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    </body>
</html>
