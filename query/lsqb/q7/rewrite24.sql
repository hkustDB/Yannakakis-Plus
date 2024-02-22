create or replace view aggView2345504013482604683 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin8691377924470524265 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView2345504013482604683 where Person_likes_Message.MessageId=aggView2345504013482604683.v1;
create or replace view aggView5636265019181978930 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2875077299529036384 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView5636265019181978930 where Message_hasTag_Tag.MessageId=aggView5636265019181978930.v1;
create or replace view aggView7503087948201673907 as select v1, SUM(annot) as annot from aggJoin2875077299529036384 group by v1;
create or replace view aggJoin8073258460353328029 as select aggJoin8691377924470524265.annot * aggView7503087948201673907.annot as annot from aggJoin8691377924470524265 join aggView7503087948201673907 using(v1);
select SUM(annot) as v9 from aggJoin8073258460353328029;
