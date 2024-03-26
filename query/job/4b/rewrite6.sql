create or replace view aggView3388755114778753106 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2001255184362036952 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3388755114778753106 where mi_idx.info_type_id=aggView3388755114778753106.v1 and info>'9.0';
create or replace view aggView1669501807962109947 as select v14, MIN(v9) as v26 from aggJoin2001255184362036952 group by v14;
create or replace view aggJoin7120047299093478729 as select id as v14, title as v15, v26 from title as t, aggView1669501807962109947 where t.id=aggView1669501807962109947.v14 and production_year>2010;
create or replace view aggView5842683071967549812 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7120047299093478729 group by v14;
create or replace view aggJoin8396925894050463878 as select keyword_id as v3, v26, v27 from movie_keyword as mk, aggView5842683071967549812 where mk.movie_id=aggView5842683071967549812.v14;
create or replace view aggView606494356296439197 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin6146981244136330666 as select v26, v27 from aggJoin8396925894050463878 join aggView606494356296439197 using(v3);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin6146981244136330666;
