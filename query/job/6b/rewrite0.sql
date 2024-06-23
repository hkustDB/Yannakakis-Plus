create or replace view aggView7305139649530076766 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin975627963591740806 as select movie_id as v23, v35 from movie_keyword as mk, aggView7305139649530076766 where mk.keyword_id=aggView7305139649530076766.v8;
create or replace view aggView4037541652240272636 as select v23, MIN(v35) as v35 from aggJoin975627963591740806 group by v23;
create or replace view aggJoin4573689463465410643 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView4037541652240272636 where t.id=aggView4037541652240272636.v23 and production_year>2014;
create or replace view aggView7679677993378284881 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin4573689463465410643 group by v23;
create or replace view aggJoin6663399569543885425 as select person_id as v14, v35, v37 from cast_info as ci, aggView7679677993378284881 where ci.movie_id=aggView7679677993378284881.v23;
create or replace view aggView8685394320243905642 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin5087578954090330576 as select v35, v37, v36 from aggJoin6663399569543885425 join aggView8685394320243905642 using(v14);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin5087578954090330576;
