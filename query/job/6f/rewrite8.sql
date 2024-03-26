create or replace view aggView4712581109508203384 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin846103419172404271 as select movie_id as v23, v35 from movie_keyword as mk, aggView4712581109508203384 where mk.keyword_id=aggView4712581109508203384.v8;
create or replace view aggView5923990457166955735 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin7216470435425557920 as select v23, v35, v37 from aggJoin846103419172404271 join aggView5923990457166955735 using(v23);
create or replace view aggView8148358531076860658 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin7216470435425557920 group by v23;
create or replace view aggJoin6663657930252092886 as select person_id as v14, v35, v37 from cast_info as ci, aggView8148358531076860658 where ci.movie_id=aggView8148358531076860658.v23;
create or replace view aggView3773196075547970679 as select v14, MIN(v35) as v35, MIN(v37) as v37 from aggJoin6663657930252092886 group by v14;
create or replace view aggJoin1662725741661731199 as select name as v15, v35, v37 from name as n, aggView3773196075547970679 where n.id=aggView3773196075547970679.v14;
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin1662725741661731199;
