create or replace view aggView8579719955820784827 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1495190154652124359 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8579719955820784827 where Person_likes_Message.MessageId=aggView8579719955820784827.v1;
create or replace view aggView3058889053291422284 as select v1, SUM(annot) as annot from aggJoin1495190154652124359 group by v1;
create or replace view aggJoin1122355969710309612 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView3058889053291422284 where Message_hasCreator_Person.MessageId=aggView3058889053291422284.v1;
create or replace view aggView6386072874666142886 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin3590480383760932362 as select aggJoin1122355969710309612.annot * aggView6386072874666142886.annot as annot from aggJoin1122355969710309612 join aggView6386072874666142886 using(v1);
select SUM(annot) as v9 from aggJoin3590480383760932362;
