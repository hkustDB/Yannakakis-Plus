create or replace view aggView8880645225656250858 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin2945586490441637017 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8880645225656250858 where Comment_replyOf_Message.ParentMessageId=aggView8880645225656250858.v1;
create or replace view aggView2596190965982706031 as select v1, SUM(annot) as annot from aggJoin2945586490441637017 group by v1;
create or replace view aggJoin7064865229875438182 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView2596190965982706031 where Message_hasTag_Tag.MessageId=aggView2596190965982706031.v1;
create or replace view aggView4219567064701416170 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin6180887198084051039 as select aggJoin7064865229875438182.annot * aggView4219567064701416170.annot as annot from aggJoin7064865229875438182 join aggView4219567064701416170 using(v1);
select SUM(annot) as v9 from aggJoin6180887198084051039;
