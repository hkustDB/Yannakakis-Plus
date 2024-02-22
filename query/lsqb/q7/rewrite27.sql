create or replace view aggView6871719460295232658 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin6743808132237159736 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView6871719460295232658 where Message_hasCreator_Person.MessageId=aggView6871719460295232658.v1;
create or replace view aggView4391718406656542714 as select v1, SUM(annot) as annot from aggJoin6743808132237159736 group by v1;
create or replace view aggJoin7352706445033965298 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4391718406656542714 where Message_hasTag_Tag.MessageId=aggView4391718406656542714.v1;
create or replace view aggView7681549433634826045 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin3521067815925588891 as select aggJoin7352706445033965298.annot * aggView7681549433634826045.annot as annot from aggJoin7352706445033965298 join aggView7681549433634826045 using(v1);
select SUM(annot) as v9 from aggJoin3521067815925588891;
