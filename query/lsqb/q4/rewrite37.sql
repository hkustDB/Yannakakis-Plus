## AggReduce Phase: 

# AggReduce111
# 1. aggView
create or replace view aggView1777170084094405674 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin8069068077942316450 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1777170084094405674 where Person_likes_Message.MessageId=aggView1777170084094405674.v1;

# AggReduce112
# 1. aggView
create or replace view aggView6160834781347567412 as select v1, SUM(annot) as annot from aggJoin8069068077942316450 group by v1;
# 2. aggJoin
create or replace view aggJoin4496780382075374385 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6160834781347567412 where Comment_replyOf_Message.ParentMessageId=aggView6160834781347567412.v1;

# AggReduce113
# 1. aggView
create or replace view aggView5530545175472862530 as select v1, SUM(annot) as annot from aggJoin4496780382075374385 group by v1;
# 2. aggJoin
create or replace view aggJoin3335356307159693654 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5530545175472862530 where Message_hasCreator_Person.MessageId=aggView5530545175472862530.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin3335356307159693654;

# drop view aggView1777170084094405674, aggJoin8069068077942316450, aggView6160834781347567412, aggJoin4496780382075374385, aggView5530545175472862530, aggJoin3335356307159693654;
