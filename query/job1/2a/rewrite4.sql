create or replace view aggView6359158088915621233 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin445124059209371502 as select movie_id as v12 from movie_companies as mc, aggView6359158088915621233 where mc.company_id=aggView6359158088915621233.v1;
create or replace view aggView5324377726215774169 as select v12 from aggJoin445124059209371502 group by v12;
create or replace view aggJoin3752047814317822545 as select id as v12, title as v20 from title as t, aggView5324377726215774169 where t.id=aggView5324377726215774169.v12;
create or replace view aggView8554458619225666165 as select v12, MIN(v20) as v31 from aggJoin3752047814317822545 group by v12;
create or replace view aggJoin4250132864395636905 as select keyword_id as v18, v31 from movie_keyword as mk, aggView8554458619225666165 where mk.movie_id=aggView8554458619225666165.v12;
create or replace view aggView1546761471163816895 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5760694553368590122 as select v31 from aggJoin4250132864395636905 join aggView1546761471163816895 using(v18);
select MIN(v31) as v31 from aggJoin5760694553368590122;
