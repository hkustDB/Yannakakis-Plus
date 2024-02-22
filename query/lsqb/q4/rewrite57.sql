create or replace view aggView8263719277412531285 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin1322006244776308665 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8263719277412531285 where Message_hasTag_Tag.MessageId=aggView8263719277412531285.v1;
create or replace view aggView4301560845068428699 as select v1, SUM(annot) as annot from aggJoin1322006244776308665 group by v1;
create or replace view aggJoin1430099009400479714 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView4301560845068428699 where Message_hasCreator_Person.MessageId=aggView4301560845068428699.v1;
create or replace view aggView5143767454102821145 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin3719622059593521502 as select aggJoin1430099009400479714.annot * aggView5143767454102821145.annot as annot from aggJoin1430099009400479714 join aggView5143767454102821145 using(v1);
select SUM(annot) as v9 from aggJoin3719622059593521502;
