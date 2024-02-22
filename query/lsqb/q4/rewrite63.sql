create or replace view aggView4949541269585705113 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin4994675505067084180 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4949541269585705113 where Person_likes_Message.MessageId=aggView4949541269585705113.v1;
create or replace view aggView3806638831627679556 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin2412785573535448320 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView3806638831627679556 where Message_hasTag_Tag.MessageId=aggView3806638831627679556.v1;
create or replace view aggView5935206033423752090 as select v1, SUM(annot) as annot from aggJoin2412785573535448320 group by v1;
create or replace view aggJoin3784202605310731033 as select aggJoin4994675505067084180.annot * aggView5935206033423752090.annot as annot from aggJoin4994675505067084180 join aggView5935206033423752090 using(v1);
select SUM(annot) as v9 from aggJoin3784202605310731033;
