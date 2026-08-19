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
model Level {
  @visibility(Lifecycle.Read)
  id: string;
  number: int32;
  exercisesTypes: ExerciseType[];
  digitsQuantity: int32;
}

@doc("Data for creating or updating a level.")
model LevelCreate {
  number: int32;
  exercisesTypes: ExerciseType[];
  digitsQuantity: int32;
}

@doc("The level was created successfully.")
model LevelCreated {
  @statusCode _: 201;

  @body body: Level;
}

@doc("API error description.")
@error
model ApiError {
  code: string;
  message: string;
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

@route("/levels")
interface Levels {
  @get
  list(): Level[];

  @get
  get(@path id: string): Level | NotFound;

  @post
  create(@bodyRoot body: LevelCreate): LevelCreated;

  @put
  update(@path id: string, @bodyRoot body: LevelCreate): Level | NotFound;

  @delete
  delete(@path id: string): NoContentResponse | NotFound;
}


