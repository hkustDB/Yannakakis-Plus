create or replace view aggView7690526375797266020 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin3872746649444249442 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7690526375797266020 where Person_likes_Message.MessageId=aggView7690526375797266020.v1;
create or replace view aggView6604130551454903849 as select v1, SUM(annot) as annot from aggJoin3872746649444249442 group by v1;
create or replace view aggJoin6125354403876539057 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6604130551454903849 where Comment_replyOf_Message.ParentMessageId=aggView6604130551454903849.v1;
create or replace view aggView61587662034253004 as select v1, SUM(annot) as annot from aggJoin6125354403876539057 group by v1;
create or replace view aggJoin5964872456519954753 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView61587662034253004 where Message_hasTag_Tag.MessageId=aggView61587662034253004.v1;
select SUM(annot) as v9 from aggJoin5964872456519954753;
