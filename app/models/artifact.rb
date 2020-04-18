class Artifact < ApplicationRecord
  attr_accessor :upload
  mount_uploader :key, KeyUploader


  belongs_to :project

  MAX_FILESIZE = 10.megabytes

  validates_presence_of :name, :key

  validates_uniqueness_of :name

  validate :uploaded_file_size

  def uploaded_file_size
    if upload
      errors.add(:key, "File size must be less than #{self.class::MAX_FILESIZE}") unless upload.size <= self.class::MAX_FILESIZE
    end
  end
end
