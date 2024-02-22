create or replace view aggView7818322780647484563 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin660973644847217551 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7818322780647484563 where Comment_replyOf_Message.ParentMessageId=aggView7818322780647484563.v1;
create or replace view aggView2876301877334280038 as select v1, SUM(annot) as annot from aggJoin660973644847217551 group by v1;
create or replace view aggJoin1845487204417127863 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2876301877334280038 where Person_likes_Message.MessageId=aggView2876301877334280038.v1;
create or replace view aggView1637306508533129455 as select v1, SUM(annot) as annot from aggJoin1845487204417127863 group by v1;
create or replace view aggJoin1335899735278286959 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1637306508533129455 where Message_hasTag_Tag.MessageId=aggView1637306508533129455.v1;
select SUM(annot) as v9 from aggJoin1335899735278286959;
