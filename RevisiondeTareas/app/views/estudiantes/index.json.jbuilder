json.array!(@estudiantes) do |estudiante|
  json.extract! estudiante, :id, :name, :lastname, :asignatura, :email, :edad, :gender
  json.url estudiante_url(estudiante, format: :json)
end
