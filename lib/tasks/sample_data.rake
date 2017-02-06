namespace :db do
  desc 'Add a sample user, notes and attachments to the database'

  task populate: :environment do

    def random_phrase
      Faker::Lorem.words(4, true).join(' ').capitalize
    end

    user = User.create!(login: 'john.doe', firstname: 'John', lastname: 'Doe',
      email: 'john.doe@example.com', password: 'qwerty')

    sample_data_path = File.join('lib', 'assets', 'sample_data')
    attachments_path = File.join(sample_data_path, 'attachments')

    # create the user notes from the lorem_markdown file
    note_descriptions = File.open(File.join(sample_data_path, 'lorem_markdown')).read.split("\n"*4)
    note_descriptions.each do |description|
      user.notes.create!(title: random_phrase, description: description)
    end

    # read all attachment files and put them into an array
    files = []
    Dir.foreach(attachments_path) do |entry|
      next if File.directory?(entry)
      file = File.open(File.join(attachments_path, entry))
      files.push(file)
    end

    # randomly attach from 0 to 5 files to each of the user's notes
    user.notes.each do |note|
      files.shuffle.first(rand(6)).each do |file|
        note.attachments.create!(file: file)
      end
    end
  end
end