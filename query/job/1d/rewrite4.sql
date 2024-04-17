create or replace view aggView8277961083698949980 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin7697012572184049290 as select movie_id as v15, company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView8277961083698949980 where mc.movie_id=aggView8277961083698949980.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView5509572245339958128 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin3574504018716430342 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5509572245339958128 where mi_idx.info_type_id=aggView5509572245339958128.v3;
create or replace view aggView4027136628448006209 as select v15 from aggJoin3574504018716430342 group by v15;
create or replace view aggJoin7582758047217742067 as select v1, v9, v28 as v28, v29 as v29 from aggJoin7697012572184049290 join aggView4027136628448006209 using(v15);
create or replace view aggView5722941349052995227 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin725488251743975086 as select v9, v28, v29 from aggJoin7582758047217742067 join aggView5722941349052995227 using(v1);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin725488251743975086;
