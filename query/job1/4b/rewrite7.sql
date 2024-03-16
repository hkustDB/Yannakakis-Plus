create or replace view aggView3087940661063841534 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin8207164863802724479 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3087940661063841534 where mi_idx.info_type_id=aggView3087940661063841534.v1 and info>'9.0';
create or replace view aggView2632497555428473271 as select v14, MIN(v9) as v26 from aggJoin8207164863802724479 group by v14;
create or replace view aggJoin7450513657384535140 as select id as v14, title as v15, v26 from title as t, aggView2632497555428473271 where t.id=aggView2632497555428473271.v14 and production_year>2010;
create or replace view aggView26744629067728218 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin8161962534330147208 as select movie_id as v14 from movie_keyword as mk, aggView26744629067728218 where mk.keyword_id=aggView26744629067728218.v3;
create or replace view aggView3439500617410887049 as select v14 from aggJoin8161962534330147208 group by v14;
create or replace view aggJoin911459709856405578 as select v15, v26 as v26 from aggJoin7450513657384535140 join aggView3439500617410887049 using(v14);
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin911459709856405578;
