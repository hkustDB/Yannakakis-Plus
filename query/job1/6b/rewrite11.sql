create or replace view aggView3782054163909841705 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4780361293260337384 as select movie_id as v23, v36 from cast_info as ci, aggView3782054163909841705 where ci.person_id=aggView3782054163909841705.v14;
create or replace view aggView759805951058467181 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin3032549414419835942 as select movie_id as v23, v35 from movie_keyword as mk, aggView759805951058467181 where mk.keyword_id=aggView759805951058467181.v8;
create or replace view aggView5157026929107656752 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin5603700432730626562 as select v23, v36, v37 from aggJoin4780361293260337384 join aggView5157026929107656752 using(v23);
create or replace view aggView2021877922560585412 as select v23, MIN(v35) as v35 from aggJoin3032549414419835942 group by v23;
create or replace view aggJoin3248090762380196837 as select v36 as v36, v37 as v37, v35 from aggJoin5603700432730626562 join aggView2021877922560585412 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3248090762380196837;
