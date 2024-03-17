create or replace view aggView920517894778671551 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6747942570103940991 as select movie_id as v23, v35 from movie_keyword as mk, aggView920517894778671551 where mk.keyword_id=aggView920517894778671551.v8;
create or replace view aggView8159732486181368293 as select id as v14, name as v36 from name as n;
create or replace view aggJoin3230446730123201837 as select movie_id as v23, v36 from cast_info as ci, aggView8159732486181368293 where ci.person_id=aggView8159732486181368293.v14;
create or replace view aggView7978866362622514861 as select v23, MIN(v35) as v35 from aggJoin6747942570103940991 group by v23;
create or replace view aggJoin4013355860184347246 as select id as v23, title as v24, v35 from title as t, aggView7978866362622514861 where t.id=aggView7978866362622514861.v23 and production_year>2000;
create or replace view aggView1696192340583874008 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4013355860184347246 group by v23;
create or replace view aggJoin7040142290074282998 as select v36 as v36, v35, v37 from aggJoin3230446730123201837 join aggView1696192340583874008 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin7040142290074282998;
