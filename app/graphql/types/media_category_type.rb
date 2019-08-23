module Types
  class MediaCategoryType < Types::BaseEnum
    value 'AUDIO', 'An audio file, such as music or spoken word'
    value 'IMAGE', 'A still image, such as a photo or graphic'
    value 'TEXT', 'Written words'
    value 'VIDEO', 'Motion picture, may have audios'
  end
end
