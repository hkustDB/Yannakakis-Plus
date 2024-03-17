create or replace view aggView598140981721896773 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin4665190153834472245 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView598140981721896773 where mi_idx.info_type_id=aggView598140981721896773.v1 and info>'9.0';
create or replace view aggView2457770203134047445 as select v14, MIN(v9) as v26 from aggJoin4665190153834472245 group by v14;
create or replace view aggJoin8004950166452908927 as select id as v14, title as v15, v26 from title as t, aggView2457770203134047445 where t.id=aggView2457770203134047445.v14 and production_year>2010;
create or replace view aggView7008441391763559530 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin8004950166452908927 group by v14;
create or replace view aggJoin7508346440083789985 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView7008441391763559530 where mk.movie_id=aggView7008441391763559530.v14;
create or replace view aggView1699147854619016127 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6790102233068473512 as select v26, v27 from aggJoin7508346440083789985 join aggView1699147854619016127 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6790102233068473512;
