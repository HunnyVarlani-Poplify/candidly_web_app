module ValidateEmailUniquenessAcrossModels
  extend ActiveSupport::Concern

  @@included_classes = []

  included do
    @@included_classes << self
    validate :email_unique_across_all_models
  end

  private

  def email_unique_across_all_models
    return if self.email.blank?
    @@included_classes.each do |klass|
      scope = klass.where(email: self.email)
      if self.persisted? && klass == self.class
        scope = scope.where.not(id: self.id)
      end
      if scope.any?
        self.errors.add :email, I18n.t('common.email_already_taken')
      end
    end
  end
end
