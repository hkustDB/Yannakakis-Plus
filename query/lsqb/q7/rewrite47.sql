create or replace view aggView8586365770525352939 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin9138834255299981955 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8586365770525352939 where Message_hasCreator_Person.MessageId=aggView8586365770525352939.v1;
create or replace view aggView6248134116234837482 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin9004735239590972917 as select v1, aggJoin9138834255299981955.annot * aggView6248134116234837482.annot as annot from aggJoin9138834255299981955 join aggView6248134116234837482 using(v1);
create or replace view aggView7631399186619256712 as select v1, SUM(annot) as annot from aggJoin9004735239590972917 group by v1;
create or replace view aggJoin9065229041338222927 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7631399186619256712 where Message_hasTag_Tag.MessageId=aggView7631399186619256712.v1;
select SUM(annot) as v9 from aggJoin9065229041338222927;
