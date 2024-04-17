create or replace view aggView476925695655217363 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8871925200662430637 as select movie_id as v12 from movie_companies as mc, aggView476925695655217363 where mc.company_id=aggView476925695655217363.v1;
create or replace view aggView4524755604578677061 as select v12 from aggJoin8871925200662430637 group by v12;
create or replace view aggJoin4169065537312437611 as select id as v12, title as v20 from title as t, aggView4524755604578677061 where t.id=aggView4524755604578677061.v12;
create or replace view aggView877314581138885227 as select v12, MIN(v20) as v31 from aggJoin4169065537312437611 group by v12;
create or replace view aggJoin6543664048512262536 as select keyword_id as v18, v31 from movie_keyword as mk, aggView877314581138885227 where mk.movie_id=aggView877314581138885227.v12;
create or replace view aggView4933614023539075153 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1515852111105969728 as select v31 from aggJoin6543664048512262536 join aggView4933614023539075153 using(v18);
select MIN(v31) as v31 from aggJoin1515852111105969728;
