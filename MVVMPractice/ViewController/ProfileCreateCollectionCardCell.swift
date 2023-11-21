import Foundation
import UIKit
import SnapKit

class ProfileCreateCollectionCardCell: UITableViewCell,UITextViewDelegate,UIScrollViewDelegate {
    
    static let identifier = "ProfileCreateCollectionCardCell"
    
    var collectionCardTextView: UITextView!
    var collectionCardTitle : UILabel!
    var collectionImage : UIImageView!
        

    var imageScrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        
        return scrollView
    }()
    
    var pageControl = UIPageControl()

    var indexPath: IndexPath?
    
    let images = ["cat","owl","cat","owl"]
    
    let descriptionLabel : UILabel = {
       let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 16)
        
        return label
    }()
    
    let menuBtn : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.tintColor = .label
        
        return btn
    }()
    
    let wordCountLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()
    
    var fullSize = UIScreen.main.bounds.width

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    
    }
   
    
    func configure(){
        
        print(contentView.frame.width)
        
        collectionCardTitle = UILabel()
        contentView.addSubview(collectionCardTitle)
                
        collectionCardTextView = UITextView()
        contentView.addSubview(collectionCardTextView)
        collectionCardTextView.delegate = self
        collectionCardTextView.addSubview(descriptionLabel)
        
        contentView.addSubview(wordCountLabel)
        
        wordCountLabel.text = "0 / 1000"
        descriptionLabel.text = "What is this place about? (Optional)"
        
        contentView.addSubview(imageScrollView)
        contentView.addSubview(pageControl)

        setupConstraints()
       
        configureScrollView()
        configurePageControl()
        
        
    }
    
    func configureScrollView(){

        imageScrollView.delegate = self
        imageScrollView.isScrollEnabled = true
        imageScrollView.bounces = false
        imageScrollView.isPagingEnabled = true
                        
        for (index, imageName) in images.enumerated(){
            let imageView = UIImageView(image: UIImage(named: imageName))
            imageView.contentMode = .scaleToFill
            imageView.frame = CGRect(x: CGFloat(index) * fullSize,
                                     y: 0,
                                     width: fullSize,
                                     height: fullSize)
            imageView.layer.borderColor = UIColor.blue.cgColor
            imageView.layer.borderWidth = 2
            imageScrollView.addSubview(imageView)
        }
                
        imageScrollView.contentSize.width = CGFloat(images.count) * fullSize
        imageScrollView.contentSize.height = 0
        contentView.addSubview(imageScrollView)
      
    }
    
    func configurePageControl(){

        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.black
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        
//        pageControl.addTarget(self, action: #selector(pageChanged), for: .valueChanged)
    }
    
    @objc func pageChanged() {
        let offset = CGPoint(x: (contentView.frame.width) * CGFloat(pageControl.currentPage),
                             y: 0)
        imageScrollView.setContentOffset(offset, animated: true)
        
        
    }
    
    @objc func isPlaceHolderHidden(){
        descriptionLabel.isHidden = collectionCardTextView.text == "" ? false : true
    }
    
    func setupConstraints() {
        contentView.layer.borderColor = UIColor.red.cgColor
        contentView.layer.borderWidth = 5

        let padding: CGFloat = 10
        let textSize = collectionCardTitle.sizeThatFits(CGSize(width: contentView.frame.width - 30,
                                                               height: CGFloat.greatestFiniteMagnitude))
        let textHeight = textSize.height

        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        collectionCardTitle.translatesAutoresizingMaskIntoConstraints = false
        collectionCardTextView.translatesAutoresizingMaskIntoConstraints = false
        wordCountLabel.translatesAutoresizingMaskIntoConstraints = false
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        
    
        // Place name
        collectionCardTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-35)
            make.height.equalTo(textHeight + padding * 3)
        }
        collectionCardTitle.font = UIFont.boldSystemFont(ofSize: 20)
                
        // TextView
        collectionCardTextView.snp.makeConstraints { make in
            make.top.equalTo(collectionCardTitle.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
        }
        
        collectionCardTextView.font = UIFont.systemFont(ofSize: 13)
        collectionCardTextView.isScrollEnabled = false
        
        
        // TextView hint label
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(collectionCardTextView)
            make.left.equalTo(collectionCardTextView).offset(5)
        }
        
        
        // Word Count
        wordCountLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionCardTextView.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-20)
        }
  
        imageScrollView.snp.makeConstraints { make in
            make.top.equalTo(wordCountLabel.snp.bottom).offset(10)
            make.height.equalTo(contentView.frame.width)
//            make.width.equalTo(contentView.frame.width)
            make.left.equalTo(contentView)
            make.right.equalTo(contentView)
            
        }
        imageScrollView.layer.borderColor = UIColor.green.cgColor
        imageScrollView.layer.borderWidth = 2
        
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(imageScrollView.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
            make.height.equalTo(30)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
            
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        collectionCardTextView.text = nil
        collectionCardTitle.text = nil
        wordCountLabel.text = nil
      
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func textViewDidChange(_ textView: UITextView) {
        descriptionLabel.isHidden = collectionCardTextView.text.count == 0 ? false : true
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentString = textView.text ?? ""
        guard let stringRange = Range(range,in: currentString) else{return false}
        let updatedText = currentString.replacingCharacters(in: stringRange, with: text)
        return updatedText.count <= 1000
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        pageControl.currentPage = Int(page)

    }
    
}
