clear;clc;

im = double(imread('tekst.png'))/255;

gim=rgb2gray(im);

heightImage = size(im,1);
bim=~imbinarize(gim);

figure,imshow(~bim);
hold on;

flag = true;
index=1;
start_y=zeros(heightImage);
end_y=zeros(heightImage);

for i=1:heightImage
    if sum(bim(i,:))>0
        if flag
           start_y(index)=i;
           flag=false;
        end
    else
        if ~flag && i>1
            end_y(index)=i;
            index=index+1;
            flag=true;
        end
        
    end
end

tab=zeros(1,1,4);

indexTab=1;
dotFlag=false;
indexSpace=1;
wordIndex=1;

for i=1:index-1
    temp=bim(start_y(i):end_y(i),:);
    indexSpace=1;
    
    temp_words=imdilate(temp,ones(5));

    word=regionprops(temp_words,'BoundingBox');
    
    l=bwlabel(temp);
    boxes=regionprops(temp,'BoundingBox');
    ns=size(boxes,1);
    testSpace=word(indexSpace).BoundingBox(1)+word(indexSpace).BoundingBox(3);

    for j=1:ns
        currentBox=boxes(j).BoundingBox;
        if currentBox(1)>testSpace
            indexSpace=indexSpace+1;
            testSpace=word(indexSpace).BoundingBox(1)+word(indexSpace).BoundingBox(3);
            wordIndex=wordIndex+1;
            indexTab=1;
        end
          if ~dotFlag
            newBox=cut2OwnSize(bim,[currentBox(1),start_y(i),currentBox(3),end_y(i)-start_y(i)]);
            rectangle('position',[currentBox(1),start_y(i)-1+newBox(2),currentBox(3),newBox(4)]);
            
            tab(wordIndex,indexTab,:)=[currentBox(1),start_y(i)-1+newBox(2),currentBox(3),newBox(4)];
            indexTab=indexTab+1;
            
          end
          dotFlag=false;
        if(j<ns-1)
           nextBoxLeft=boxes(j+1).BoundingBox(1);
           if(nextBoxLeft>currentBox(1)&&nextBoxLeft<(currentBox(1)+currentBox(3)))
               dotFlag=true;
           end
        end          
    end
    wordIndex=wordIndex+1;
    indexTab=1;
    tab(wordIndex,indexTab,:)=newline;
    wordIndex=wordIndex+1;
end

