create or replace view aggView7274736062144363001 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5988124128696285548 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView7274736062144363001 where mk.movie_id=aggView7274736062144363001.v23;
create or replace view aggView3485452128218590962 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin645283982364768937 as select v23, v37, v35 from aggJoin5988124128696285548 join aggView3485452128218590962 using(v8);
create or replace view aggView8109647273301190944 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4933686835547924181 as select movie_id as v23, v36 from cast_info as ci, aggView8109647273301190944 where ci.person_id=aggView8109647273301190944.v14;
create or replace view aggView6146485180292520105 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin645283982364768937 group by v23,v35,v37;
create or replace view aggJoin2885121554216584916 as select v36 as v36, v37, v35 from aggJoin4933686835547924181 join aggView6146485180292520105 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin2885121554216584916;
