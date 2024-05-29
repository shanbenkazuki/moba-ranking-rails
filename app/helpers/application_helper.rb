module ApplicationHelper
  def default_meta_tags
    {
      site: 'moba-ranking',
      title: 'MOBA Tier Rankings',
      description: 'MOBA関連のTierをランキング形式で公開しています。',
      canonical: request.original_url,
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        url: request.original_url,
        image: image_url('default-ogp.png'),
      },
      twitter: {
        card: 'summary_large_image',
        site: '@あなたのツイッターアカウント',
        title: :title,
        description: :description,
        image: image_url('default-ogp.png'),
      }
    }
  end
end