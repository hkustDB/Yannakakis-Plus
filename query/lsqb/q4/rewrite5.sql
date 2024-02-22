create or replace view aggView4220294743089881609 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin8439913624018280161 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4220294743089881609 where Message_hasTag_Tag.MessageId=aggView4220294743089881609.v1;
create or replace view aggView2281777482742406709 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5038888726021676204 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2281777482742406709 where Comment_replyOf_Message.ParentMessageId=aggView2281777482742406709.v1;
create or replace view aggView7682328398091598924 as select v1, SUM(annot) as annot from aggJoin5038888726021676204 group by v1;
create or replace view aggJoin2604825817190818582 as select aggJoin8439913624018280161.annot * aggView7682328398091598924.annot as annot from aggJoin8439913624018280161 join aggView7682328398091598924 using(v1);
select SUM(annot) as v9 from aggJoin2604825817190818582;
