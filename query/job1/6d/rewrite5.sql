create or replace view aggView5973815554065290055 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8351601010113736832 as select movie_id as v23, v35 from movie_keyword as mk, aggView5973815554065290055 where mk.keyword_id=aggView5973815554065290055.v8;
create or replace view aggView3466398265611273651 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2455145935021314216 as select movie_id as v23, v36 from cast_info as ci, aggView3466398265611273651 where ci.person_id=aggView3466398265611273651.v14;
create or replace view aggView5130592657771047248 as select v23, MIN(v35) as v35 from aggJoin8351601010113736832 group by v23;
create or replace view aggJoin6514076620718910750 as select id as v23, title as v24, v35 from title as t, aggView5130592657771047248 where t.id=aggView5130592657771047248.v23 and production_year>2000;
create or replace view aggView5288041007869009971 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin6514076620718910750 group by v23;
create or replace view aggJoin5122071668740828 as select v36 as v36, v35, v37 from aggJoin2455145935021314216 join aggView5288041007869009971 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5122071668740828;
