create or replace view aggView4700079116286265674 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7224278936994155994 as select movie_id as v14 from movie_keyword as mk, aggView4700079116286265674 where mk.keyword_id=aggView4700079116286265674.v3;
create or replace view aggView3713390944864598534 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin6114904764383952877 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3713390944864598534 where mi_idx.info_type_id=aggView3713390944864598534.v1 and info>'2.0';
create or replace view aggView5972305199506823159 as select v14, MIN(v9) as v26 from aggJoin6114904764383952877 group by v14;
create or replace view aggJoin1512921438131270683 as select id as v14, title as v15, v26 from title as t, aggView5972305199506823159 where t.id=aggView5972305199506823159.v14 and production_year>1990;
create or replace view aggView8692740883473400275 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin1512921438131270683 group by v14;
create or replace view aggJoin7423902718421415732 as select v26, v27 from aggJoin7224278936994155994 join aggView8692740883473400275 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin7423902718421415732;
