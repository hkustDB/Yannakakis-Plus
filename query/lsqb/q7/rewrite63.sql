create or replace view aggView7302107380101295420 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7534007016721389281 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7302107380101295420 where Message_hasTag_Tag.MessageId=aggView7302107380101295420.v1;
create or replace view aggView3876171487176999101 as select v1, SUM(annot) as annot from aggJoin7534007016721389281 group by v1;
create or replace view aggJoin5937627542983910975 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3876171487176999101 where Comment_replyOf_Message.ParentMessageId=aggView3876171487176999101.v1;
create or replace view aggView9071528788009618753 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6216748777468264726 as select aggJoin5937627542983910975.annot * aggView9071528788009618753.annot as annot from aggJoin5937627542983910975 join aggView9071528788009618753 using(v1);
select SUM(annot) as v9 from aggJoin6216748777468264726;
