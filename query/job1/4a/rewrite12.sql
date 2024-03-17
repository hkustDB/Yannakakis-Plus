create or replace view aggView2978850045157629666 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2484034611887312888 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView2978850045157629666 where mi_idx.info_type_id=aggView2978850045157629666.v1 and info>'5.0';
create or replace view aggView5037354006262895496 as select v14, MIN(v9) as v26 from aggJoin2484034611887312888 group by v14;
create or replace view aggJoin6161327212366652611 as select id as v14, title as v15, v26 from title as t, aggView5037354006262895496 where t.id=aggView5037354006262895496.v14 and production_year>2005;
create or replace view aggView9219498400859443587 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1894847715030085082 as select movie_id as v14 from movie_keyword as mk, aggView9219498400859443587 where mk.keyword_id=aggView9219498400859443587.v3;
create or replace view aggView7780465337609055837 as select v14 from aggJoin1894847715030085082 group by v14;
create or replace view aggJoin4545951404666878090 as select v15, v26 as v26 from aggJoin6161327212366652611 join aggView7780465337609055837 using(v14);
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin4545951404666878090;
