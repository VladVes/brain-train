import "@typespec/http";
import "@typespec/rest";

using Http;

@service(#{ title: "Brain-Train API" })
namespace BrainTrain;

@doc("An exercise type for memory training.")
model ExerciseType {
  @visibility(Lifecycle.Read)
  id: string;
  name: string;
  desc: string;
}

@doc("Data for creating or updating an exercise type.")
model ExerciseTypeCreate {
  name: string;
  desc: string;
}

@doc("The exercise type was created successfully.")
model ExerciseTypeCreated {
  @statusCode _: 201;

  @body body: ExerciseType;
}

@doc("A level of memory training with a set of exercise types.")
model ExerciseLevel {
  @visibility(Lifecycle.Read)
  id: string;
  number: int32;
  exercisesTypes: ExerciseType[];
  digitsQuantity: int32;
}

@doc("Data for creating or updating a level.")
model ExerciseLevelCreate {
  number: int32;
  exercisesTypes: ExerciseType[];
  digitsQuantity: int32;
}

@doc("The level was created successfully.")
model ExerciseLevelCreated {
  @statusCode _: 201;

  @body body: ExerciseLevel;
}

@doc("API error description.")
@error
model ApiError {
  code: string;
  message: string;
}

@doc("Status of an exercise attempt.")
enum ExerciseStatus {
  solved,
  failed,
}

@doc("An exercise of the memory training.")
model Exercise {
  @visibility(Lifecycle.Read)
  id: string;
  points: int32;
  status: ExerciseStatus;
  type: ExerciseType;
  level: ExerciseLevel;
}

@doc("Data for creating or updating an exercise.")
model ExerciseCreate {
  points: int32;
  status: ExerciseStatus;
  type: ExerciseType;
  level: ExerciseLevel;
}

@doc("The exercise was created successfully.")
model ExerciseCreated {
  @statusCode _: 201;

  @body body: Exercise;
}

@doc("Role of a user.")
enum UserRole {
  admin,
  player,
  guest,
}

@doc("A user of the Brain-Train application.")
model User {
  @visibility(Lifecycle.Read)
  id: string;
  name: string;
  email: string;
  otherContacts: string;
  role: UserRole;
  score: int32;
  exercises: Exercise[];
  currentLevel: ExerciseLevel;
}

@doc("Data for creating or updating a user.")
model UserCreate {
  name: string;
  email: string;
  otherContacts: string;
  role: UserRole;
  score: int32;
  exercises: Exercise[];
  currentLevel: ExerciseLevel;
}

@doc("The user was created successfully.")
model UserCreated {
  @statusCode _: 201;

  @body body: User;
}

@doc("Resource not found.")
@error
model NotFound {
  @statusCode _: 404;

  @body body: ApiError;
}

@route("/exerciseTypes")
interface ExerciseTypes {
  @get
  list(): ExerciseType[];

  @get
  get(@path id: string): ExerciseType | NotFound;

  @post
  create(@bodyRoot body: ExerciseTypeCreate): ExerciseTypeCreated;

  @put
  update(@path id: string, @bodyRoot body: ExerciseTypeCreate): ExerciseType | NotFound;

  @delete
  delete(@path id: string): NoContentResponse | NotFound;
}

@route("/exercises")
interface Exercises {
  @get
  list(): Exercise[];

  @get
  get(@path id: string): Exercise | NotFound;

  @post
  create(@bodyRoot body: ExerciseCreate): ExerciseCreated;

  @put
  update(@path id: string, @bodyRoot body: ExerciseCreate): Exercise | NotFound;

  @delete
  delete(@path id: string): NoContentResponse | NotFound;
}

@route("/exerciseLevels")
interface ExerciseLevels {
  @get
  list(): ExerciseLevel[];

  @get
  get(@path id: string): ExerciseLevel | NotFound;

  @post
  create(@bodyRoot body: ExerciseLevelCreate): ExerciseLevelCreated;

  @put
  update(@path id: string, @bodyRoot body: ExerciseLevelCreate): ExerciseLevel | NotFound;

  @delete
  delete(@path id: string): NoContentResponse | NotFound;
}

@route("/users")
interface Users {
  @get
  list(): User[];

  @get
  get(@path id: string): User | NotFound;

  @post
  create(@bodyRoot body: UserCreate): UserCreated;

  @put
  update(@path id: string, @bodyRoot body: UserCreate): User | NotFound;

  @delete
  delete(@path id: string): NoContentResponse | NotFound;
}


