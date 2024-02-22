create or replace view aggView7416443796753071056 as select l_partkey as v17, SUM(l_extendedprice) as v28, COUNT(*) as annot, l_quantity as v5 from lineitem as lineitem group by l_partkey,l_quantity;
create or replace view aggJoin7623731916452802748 as select p_partkey as v17, p_brand as v20, p_container as v23, v28, v5, annot from part as part, aggView7416443796753071056 where part.p_partkey=aggView7416443796753071056.v17 and p_brand= 'Brand#23' and p_container= 'MED BOX';
create or replace view aggView6227437750649745547 as select v1_partkey as v17, COUNT(*) as annot, v1_quantity_avg as v27 from view1 as view1 group by v1_partkey,v1_quantity_avg;
create or replace view aggJoin4559038508618445615 as select v28*aggView6227437750649745547.annot as v28, aggJoin7623731916452802748.annot * aggView6227437750649745547.annot as annot from aggJoin7623731916452802748 join aggView6227437750649745547 using(v17) where v5 > v27;
select (SUM(v28) / 7.0) as v29 from aggJoin4559038508618445615;
