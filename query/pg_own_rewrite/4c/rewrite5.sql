create or replace view aggView2648460108570800259 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5458491059708505865 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView2648460108570800259 where mi_idx.info_type_id=aggView2648460108570800259.v1 and info>'2.0';
create or replace view aggView5762378843238638727 as select v14, MIN(v9) as v26 from aggJoin5458491059708505865 group by v14;
create or replace view aggJoin7710586923658199274 as select id as v14, title as v15, production_year as v18, v26 from title as t, aggView5762378843238638727 where t.id=aggView5762378843238638727.v14 and production_year>1990;
create or replace view aggView8806046237120913495 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin7908238291912282667 as select movie_id as v14 from movie_keyword as mk, aggView8806046237120913495 where mk.keyword_id=aggView8806046237120913495.v3;
create or replace view aggView8878555170068413810 as select v14, MIN(v26) as v26, MIN(v15) as v27 from aggJoin7710586923658199274 group by v14,v26;
create or replace view aggJoin3201640816754791346 as select v26, v27 from aggJoin7908238291912282667 join aggView8878555170068413810 using(v14);
select MIN(v26) as v26,MIN(v27) as v27 from aggJoin3201640816754791346;
