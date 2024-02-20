## AggReduce Phase: 

# AggReduce129
# 1. aggView
create or replace view aggView5181431539692889750 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin8698692371445819892 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5181431539692889750 where Person_likes_Message.MessageId=aggView5181431539692889750.v1;

# AggReduce130
# 1. aggView
create or replace view aggView1531581859811574152 as select v1, SUM(annot) as annot from aggJoin8698692371445819892 group by v1;
# 2. aggJoin
create or replace view aggJoin2051269808907191898 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView1531581859811574152 where Message_hasTag_Tag.MessageId=aggView1531581859811574152.v1;

# AggReduce131
# 1. aggView
create or replace view aggView3411785364948097293 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4321547069839256400 as select aggJoin2051269808907191898.annot * aggView3411785364948097293.annot as annot from aggJoin2051269808907191898 join aggView3411785364948097293 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin4321547069839256400;

# drop view aggView5181431539692889750, aggJoin8698692371445819892, aggView1531581859811574152, aggJoin2051269808907191898, aggView3411785364948097293, aggJoin4321547069839256400;
