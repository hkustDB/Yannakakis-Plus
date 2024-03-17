create or replace view aggView6098486822954414359 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin1742555440347065178 as select movie_id as v12 from movie_keyword as mk, aggView6098486822954414359 where mk.keyword_id=aggView6098486822954414359.v18;
create or replace view aggView8442744383616734692 as select v12 from aggJoin1742555440347065178 group by v12;
create or replace view aggJoin1699109167268520865 as select id as v12, title as v20 from title as t, aggView8442744383616734692 where t.id=aggView8442744383616734692.v12;
create or replace view aggView8594783095057423946 as select v12, MIN(v20) as v31 from aggJoin1699109167268520865 group by v12;
create or replace view aggJoin5067146154077444354 as select company_id as v1, v31 from movie_companies as mc, aggView8594783095057423946 where mc.movie_id=aggView8594783095057423946.v12;
create or replace view aggView1858844392148726619 as select v1, MIN(v31) as v31 from aggJoin5067146154077444354 group by v1;
create or replace view aggJoin6071537767992391471 as select country_code as v3, v31 from company_name as cn, aggView1858844392148726619 where cn.id=aggView1858844392148726619.v1 and country_code= '[sm]';
select MIN(v31) as v31 from aggJoin6071537767992391471;
