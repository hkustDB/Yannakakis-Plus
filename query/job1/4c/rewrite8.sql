create or replace view aggView1040599741618839822 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4853619908232821733 as select movie_id as v14 from movie_keyword as mk, aggView1040599741618839822 where mk.keyword_id=aggView1040599741618839822.v3;
create or replace view aggView8237585270403129470 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin2007160903826898721 as select movie_id as v14, info as v9 from movie_info_idx as mi_idx, aggView8237585270403129470 where mi_idx.info_type_id=aggView8237585270403129470.v1 and info>'2.0';
create or replace view aggView6417052780792593085 as select v14, MIN(v9) as v26 from aggJoin2007160903826898721 group by v14;
create or replace view aggJoin2629494511900006457 as select v14, v26 from aggJoin4853619908232821733 join aggView6417052780792593085 using(v14);
create or replace view aggView3470952777431756507 as select v14, MIN(v26) as v26 from aggJoin2629494511900006457 group by v14;
create or replace view aggJoin3498843077672828235 as select title as v15, v26 from title as t, aggView3470952777431756507 where t.id=aggView3470952777431756507.v14 and production_year>1990;
select MIN(v26) as v26,MIN(v15) as v27 from aggJoin3498843077672828235;
