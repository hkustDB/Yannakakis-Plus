create or replace view aggView7058238463283192075 as select id as v12, title as v24 from title as t where production_year>2010;
create or replace view aggJoin5825732242735738447 as select movie_id as v12, info as v7, v24 from movie_info as mi, aggView7058238463283192075 where mi.movie_id=aggView7058238463283192075.v12 and info= 'Bulgaria';
create or replace view aggView3745130749341891025 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4832512760788029824 as select movie_id as v12 from movie_keyword as mk, aggView3745130749341891025 where mk.keyword_id=aggView3745130749341891025.v1;
create or replace view aggView2555422829880926662 as select v12 from aggJoin4832512760788029824 group by v12;
create or replace view aggJoin1338092620561397863 as select v7, v24 as v24 from aggJoin5825732242735738447 join aggView2555422829880926662 using(v12);
create or replace view res as select MIN(v24) as v24 from aggJoin1338092620561397863;
select sum(v24) from res;