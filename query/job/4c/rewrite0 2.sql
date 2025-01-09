create or replace view aggView5403271808876160508 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5432934046077757381 as select movie_id as v14 from movie_keyword as mk, aggView5403271808876160508 where mk.keyword_id=aggView5403271808876160508.v3;
create or replace view aggView3087060007984091668 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin3848672193206613258 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView3087060007984091668 where mi_idx.info_type_id=aggView3087060007984091668.v1 and info>'2.0';
create or replace view aggView7192774142091508995 as select v14 from aggJoin5432934046077757381 group by v14;
create or replace view aggJoin4825068003350411996 as select v14, v9 from aggJoin3848672193206613258 join aggView7192774142091508995 using(v14);
create or replace view aggView5575367965248760106 as select v14, MIN(v9) as v26 from aggJoin4825068003350411996 group by v14;
create or replace view aggJoin8617373168429019857 as select title as v15, v26 from title as t, aggView5575367965248760106 where t.id=aggView5575367965248760106.v14 and production_year>1990;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin8617373168429019857;
