create or replace view aggView5887547077115026171 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4065780678006784824 as select movie_id as v12 from movie_keyword as mk, aggView5887547077115026171 where mk.keyword_id=aggView5887547077115026171.v18;
create or replace view aggView8631285192196909943 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin9043786696589177734 as select movie_id as v12 from movie_companies as mc, aggView8631285192196909943 where mc.company_id=aggView8631285192196909943.v1;
create or replace view aggView11174634043515198 as select v12, COUNT(*) as annot from aggJoin9043786696589177734 group by v12;
create or replace view aggJoin7765426400224386399 as select id as v12, annot from title as t, aggView11174634043515198 where t.id=aggView11174634043515198.v12;
create or replace view aggView1007101489907716093 as select v12, SUM(annot) as annot from aggJoin7765426400224386399 group by v12;
create or replace view aggJoin713217829136475294 as select annot from aggJoin4065780678006784824 join aggView1007101489907716093 using(v12);
select SUM(annot) as v31 from aggJoin713217829136475294;
