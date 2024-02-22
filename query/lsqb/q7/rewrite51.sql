create or replace view aggView2514094861508634435 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7991518526971422595 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView2514094861508634435 where Message_hasCreator_Person.MessageId=aggView2514094861508634435.v1;
create or replace view aggView1001225946579153764 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6710715403813523691 as select v1, aggJoin7991518526971422595.annot * aggView1001225946579153764.annot as annot from aggJoin7991518526971422595 join aggView1001225946579153764 using(v1);
create or replace view aggView7465515270817599154 as select v1, SUM(annot) as annot from aggJoin6710715403813523691 group by v1;
create or replace view aggJoin5837185439921007321 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7465515270817599154 where Comment_replyOf_Message.ParentMessageId=aggView7465515270817599154.v1;
select SUM(annot) as v9 from aggJoin5837185439921007321;
