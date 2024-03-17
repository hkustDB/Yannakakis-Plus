create or replace view aggView2240827386248504950 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin6991968934899957148 as select movie_id as v23, v35 from movie_keyword as mk, aggView2240827386248504950 where mk.keyword_id=aggView2240827386248504950.v8;
create or replace view aggView342788614919869169 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7528054961197808143 as select movie_id as v23, v36 from cast_info as ci, aggView342788614919869169 where ci.person_id=aggView342788614919869169.v14;
create or replace view aggView2929192215566903142 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5416919969939733559 as select v23, v36, v37 from aggJoin7528054961197808143 join aggView2929192215566903142 using(v23);
create or replace view aggView7209300732387882128 as select v23, MIN(v35) as v35 from aggJoin6991968934899957148 group by v23;
create or replace view aggJoin6731858621176767485 as select v36 as v36, v37 as v37, v35 from aggJoin5416919969939733559 join aggView7209300732387882128 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin6731858621176767485;
