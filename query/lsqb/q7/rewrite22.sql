## AggReduce Phase: 

# AggReduce66
# 1. aggView
create or replace view aggView2417638544212581630 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin5322440120327183010 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2417638544212581630 where Comment_replyOf_Message.ParentMessageId=aggView2417638544212581630.v1;

# AggReduce67
# 1. aggView
create or replace view aggView9050094686255906539 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8135638962839382054 as select v1, aggJoin5322440120327183010.annot * aggView9050094686255906539.annot as annot from aggJoin5322440120327183010 join aggView9050094686255906539 using(v1);

# AggReduce68
# 1. aggView
create or replace view aggView2075238906235754732 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin7676101043613228484 as select aggJoin8135638962839382054.annot * aggView2075238906235754732.annot as annot from aggJoin8135638962839382054 join aggView2075238906235754732 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin7676101043613228484;

# drop view aggView2417638544212581630, aggJoin5322440120327183010, aggView9050094686255906539, aggJoin8135638962839382054, aggView2075238906235754732, aggJoin7676101043613228484;
