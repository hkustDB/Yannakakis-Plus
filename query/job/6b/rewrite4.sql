create or replace view aggView343471398828483473 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin3596945850975631864 as select movie_id as v23, v36 from cast_info as ci, aggView343471398828483473 where ci.person_id=aggView343471398828483473.v14;
create or replace view aggView7396125539998100342 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin5338918177998638038 as select movie_id as v23, v35 from movie_keyword as mk, aggView7396125539998100342 where mk.keyword_id=aggView7396125539998100342.v8;
create or replace view aggView9126605095304883302 as select v23, MIN(v35) as v35 from aggJoin5338918177998638038 group by v23,v35;
create or replace view aggJoin1086390705407624027 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView9126605095304883302 where t.id=aggView9126605095304883302.v23 and production_year>2014;
create or replace view aggView6391291139782434286 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin1086390705407624027 group by v23,v35;
create or replace view aggJoin3133047373957523780 as select v36 as v36, v35, v37 from aggJoin3596945850975631864 join aggView6391291139782434286 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3133047373957523780;
