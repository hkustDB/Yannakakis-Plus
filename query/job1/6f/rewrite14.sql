create or replace view aggView9207704028947068931 as select id as v14, name as v36 from name as n;
create or replace view aggJoin4832541359309771660 as select movie_id as v23, v36 from cast_info as ci, aggView9207704028947068931 where ci.person_id=aggView9207704028947068931.v14;
create or replace view aggView8290133063510715695 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6680207214065755520 as select movie_id as v23, v35 from movie_keyword as mk, aggView8290133063510715695 where mk.keyword_id=aggView8290133063510715695.v8;
create or replace view aggView6974078212240079349 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin1885707627434347678 as select v23, v36 from aggJoin4832541359309771660 join aggView6974078212240079349 using(v23);
create or replace view aggView5233760334423885463 as select v23, MIN(v35) as v35 from aggJoin6680207214065755520 group by v23;
create or replace view aggJoin3177174776548172012 as select v36 as v36, v35 from aggJoin1885707627434347678 join aggView5233760334423885463 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3177174776548172012;
