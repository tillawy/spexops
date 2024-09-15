# ActiveRecord model: Feature
module Features
  class Feature < ApplicationRecord
    include Discard::Model
    include WithAutoProjectId
    default_scope -> { kept }

    belongs_to :creator, class_name: User.name
    belongs_to :milestone
    belongs_to :domain
    belongs_to :project

    has_many :feature_point_of_view_memberships
    has_many :point_of_views, through: :feature_point_of_view_memberships

    validates_length_of :name, minimum: 4, maximum: 65

    attr_accessor :point_of_view_ids

    after_create do
      if point_of_view_ids && !point_of_view_ids.empty?
        point_of_views = PointOfView.find(point_of_view_ids)
        point_of_views.each do |pov|
          FeaturePointOfViewMembership.create!(feature: self, point_of_view: pov, creator: creator)
        end
      end
    end

    after_commit do
      Producers::FeaturesUpsertProducer.process(model: self)
    end


    scope :for_user, ->(user:) {
      Feature.joins(domain: {project: :project_user_memberships}).where('project_user_memberships.user': user)
    }

  end
end
