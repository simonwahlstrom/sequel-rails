require "spec_helper"
require "generator_spec/test_case"
require "generators/sequel/migration/migration_generator"

describe Sequel::Generators::MigrationGenerator do
  include GeneratorSpec::TestCase
  destination File.expand_path("../../../../internal/tmp", __FILE__)

  before { prepare_destination }

  context "when name starts with create" do
    before { run_generator ["create_authors"] }
    it "creates a new migration using change to create the table" do
      destination_root.should have_structure {
        directory "db" do
          directory "migrate" do
            migration "create_authors" do
              contains <<-CONTENT.strip_heredoc
              Sequel.migration do
                change do
                  create_table :authors do
                    primary_key :id
                  end
                end
              end
              CONTENT
            end
          end
        end
      }
    end
  end

  context "when name starts with drop" do
    context "and does not contains _from_" do
      before { run_generator ["drop_author"] }
      it "creates a new migration using up/down to drop the table" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "drop_author" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  up do
                    drop_table :authors
                  end

                  down do
                    create_table :authors do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
    context "and contains _from_" do
      before { run_generator ["drop_salary_from_authors"] }
      it "creates a new migration using up/down to drop the column from table" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "drop_salary_from_authors" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  up do
                    alter_table :authors do
                    end
                  end

                  down do
                    alter_table :authors do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
  end

  context "when name starts with add" do
    context "and does not contains _to_ nor _from_" do
      before { run_generator ["add_new_indexes"] }
      it "creates a new migration using up/down" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "add_new_indexes" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  up do
                    alter_table :add_new_indexes do
                    end
                  end

                  down do
                    alter_table :add_new_indexes do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
    context "and contains _to_" do
      before { run_generator ["add_salary_to_authors"] }
      it "creates a new migration using change to add the column to the table" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "add_salary_to_authors" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  change do
                    alter_table :authors do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
    context "and contains _from_" do
      before { run_generator ["add_salary_from_authors"] }
      it "creates a new migration using change to add the column to the table" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "add_salary_from_authors" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  change do
                    alter_table :authors do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
  end

  context "when name starts with remove" do
    context "and does not contains _to_ nor _from_" do
      before { run_generator ["remove_new_indexes"] }
      it "creates a new migration using up/down" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "remove_new_indexes" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  up do
                    alter_table :remove_new_indexes do
                    end
                  end

                  down do
                    alter_table :remove_new_indexes do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
    context "and contains _to_" do
      before { run_generator ["remove_salary_to_authors"] }
      it "creates a new migration using up/down to remove the column from the table" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "remove_salary_to_authors" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  up do
                    alter_table :authors do
                    end
                  end

                  down do
                    alter_table :authors do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
    context "and contains _from_" do
      before { run_generator ["remove_salary_from_authors"] }
      it "creates a new migration using change to remove the column from the table" do
        destination_root.should have_structure {
          directory "db" do
            directory "migrate" do
              migration "remove_salary_from_authors" do
                contains <<-CONTENT.strip_heredoc
                Sequel.migration do
                  up do
                    alter_table :authors do
                    end
                  end

                  down do
                    alter_table :authors do
                    end
                  end
                end
                CONTENT
              end
            end
          end
        }
      end
    end
  end

end
