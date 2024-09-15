# Concern to auto fill project_id from belong_to object
module WithAutoProjectId
  extend ActiveSupport::Concern

  included do
    before_validation :set_project_id, on: :create
    def set_project_id
      self.project_id = find_project_id
    end

    def find_project_id
      parent = find_relation_with_project_id
      self.send(parent.name).try(:project_id) if parent
    end

    def find_relation_with_project_id
      self.class.reflect_on_all_associations(:belongs_to).find do |a|
        class_name = a.try(:options)&.dig(:class_name) || a.name.to_s.camelcase
        clazz = class_name.constantize
        id_name = "#{a.name}_id"
        id = self.send id_name
        objects = clazz.where(id: id)
        unless objects.empty?
          objects.first.respond_to?(:project_id)
        end
      end
    end

  end
end
