class RecordPolicy < ApplicationPolicy
    attr_reader :user, :record

    def initialize(user, post)
        @user = user 
        @record = record
    end

    def create?
        user.admin?
    end

    def update?
        user.admin?
    end

    def index?
        user.admin?
    end

end